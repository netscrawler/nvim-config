return {
    'charludo/projectmgr.nvim',
    lazy = false, -- important!
    config = function()
        require("projectmgr").setup({
            -- Основные настройки
            projects_dir = "~/dev/projects",                            -- Директория, где хранятся ваши проекты
            project_files = { ".git", "package.json", "go.mod" },       -- Файлы, которые указывают на проект
            ignore_patterns = { "*.git", "*.cache" },                   -- Шаблоны для игнорирования
            sort_projects = true,                                       -- Сортировать проекты
            open_cmd = "e",                                             -- Команда для открытия проекта (например, "e" для открытия в новом буфере)
            open_new_tab = true,                                        -- Открывать проект в новой вкладке
            create_project_cmd = "Telescope projectmgr create_project", -- Команда для создания нового проекта
            delete_project_cmd = "Telescope projectmgr delete_project", -- Команда для удаления проекта
            rename_project_cmd = "Telescope projectmgr rename_project", -- Команда для переименования проекта
        })
    end
}
