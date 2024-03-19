module.exports = {
	extends: ['@commitlint/config-conventional'],
	// 定义规则类型
	rules: {
		'header-max-length': [0, 'always'],
		'scope-empty': [2, 'never'],
		'scope-enum': [2, 'always', ['mandev-react']],
		'type-enum': [2, 'always', ['build', 'ci', 'chore', 'feat', 'fix', 'refactor', 'style', 'test', 'config', 'docs']],
		'close-issue-needed': [2, 'always'],
	},
	plugins: [
		{
			rules: {
				'close-issue-needed': (msg: any) => {
					const ISSUES_CLOSED = 'ISSUES CLOSED:'
					return [msg.raw.includes(ISSUES_CLOSED), 'Your commit message must contain ISSUES message']
				},
			},
		},
	],
}
