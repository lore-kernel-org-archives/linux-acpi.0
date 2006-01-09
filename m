From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 12:34:39 +1300
Message-ID: <46a038f90601091534s7f4b36a5he05778f1ed82f34@mail.gmail.com>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
	 <Pine.LNX.4.64.0601091502200.5588@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <git-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0601091502200.5588@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Luben Tuikov <ltuikov@yahoo.com>, "Brown, Len" <len.brown@intel.com>, "Luck, Tony" <tony.luck@intel.com>, Junio C Hamano <junkio@cox.net>, "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 1/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Using many branches in the same tree is
> definitely the better approach for _distribution_, but that doesn't
> necessarily mean that it's the better one for development.
(...)
> So git certainly supports that kind of behaviour, but nobody I know
> actually does it that way

Hrm! We do. http://locke.catalyst.net.nz/gitweb?p=moodle.git;a=heads
shows a lot of heads that share 99% of the code. The repo is ~90MB --
and we check each head out with cogito, develop and push. It is a
shared team repo, using git+ssh and sticky gid and umask 002.

Works pretty well I have to add. The only odd thing is that the
fastest way to actually start working on a new branch is to ssh on to
the server and cp moodle.git/refs/heads/{foo,bar} and then cg-clone
that bar branch away. Perhaps I should code up an 'cg-branch-add
--in-server' patch.

regards,


martin
