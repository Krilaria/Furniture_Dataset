require 'sketchup'

# Define the path where the images will be exported
export_path = "D:/Мебель_Net/Dataset"

# Надо определить координаты камеры и предметов

# Define the camera settings for each view
camera_settings = [
  { name: "View 1", position: [x1, y1, z1], target: [tx1, ty1, tz1] },
  { name: "View 2", position: [x2, y2, z2], target: [tx2, ty2, tz2] },
  # Add more views here
]

# Define the furniture models and their positions
furniture = [
  { name: "Table", model: "table.skp", position: [x1, y1, z1] },
  { name: "Chair", model: "chair.skp", position: [x2, y2, z2] },
  # Add more furniture models and positions here
]

# Create a new SketchUp model
model = Sketchup.active_model

# Loop through each camera setting
camera_settings.each do |camera|
  # Set the camera position and target
  model.active_view.camera.set(camera[:position], camera[:target])

  # Loop through each furniture item
  furniture.each do |item|
    # Load the furniture model
    path = File.join(export_path, item[:model])
    definition = model.definitions.load(path)

    # Create an instance of the furniture model
    instance = model.active_entities.add_instance(definition, item[:position])

    # Export the image with a unique filename
    filename = "#{item[:name]}_#{camera[:name]}.jpg"
    export_filename = File.join(export_path, filename)
    model.active_view.write_image(export_filename, width, height, 0, true, 96)
    
    # Erase the furniture instance
    instance.erase!
  end
end

# Inform the user that the export is complete
UI.messagebox("Image export complete!")