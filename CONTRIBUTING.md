### commit message

##### Commit Message 格式

- Message 格式规范：分成标题，内容详情，结尾三部分

- 标题

``` 
<type>(<scope>): <subject>
<空行>
<body>
<空行>
<footer>
```

- Type
  - feat：新功能（feature）
  - fix：修补 bug
  - docs：文档（documentation）
  - style： 格式（不影响代码运行的变动）
  - refactor：重构（即不是新增功能，也不是修改 bug 的代码变动）
  - test：增加测试
  - chore：构建过程或辅助工具的变动
- Scope
  - 说明本次commit影响的范围，简要说明修改会设计的部分
- Subject
  - 简要描述本次改动
- Body
  - 是对Subject里内容的展开，在此做更加详尽的描述
- Footer
  - 放置不兼容的变更和Issue关闭的信息


### git flow 工作流程

- 参考链接：[https://danielkummer.github.io/git-flow-cheatsheet/index.zh_CN.html]