function save_t(name,varargin)
  save(sprintf('%s-%d',name,clock*[1e8 1e6 1e4 1e2 1 0].'),varargin{:});
end
