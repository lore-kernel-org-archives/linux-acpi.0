From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: git pull on Linux/ACPI release tree
Date: Sun, 8 Jan 2006 02:47:30 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A13489@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

adding git-u79uwXL29TaiAVqoAR/hOK1cXZ9k6wlg@public.gmane.org

>> please pull this batch of trivial patches from:=20
>>=20
>>=20
>git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git =
release
>
>Len,
>
>I _really_ wish you wouldn't have those automatic merges.
>
>Why do you do them? They add nothing but ugly and unnecessary=20
>history, and in this pull, I think almost exactly half of the
>commits were just these empty merges.

Is it possible for it git, like bk, to simply ignore merge commits in i=
ts summary output?

Note that "Auto-update from upstream" is just the place-holder comment
embedded in the wrapper script in git/Documentation/howto/using-topic-b=
ranches.txt
All instances of it here are from me manually updating --
the only "auto" happening here is the automatic insertion of that comme=
nt:-)

I think that Tony's howto above captures two key requirements
from all kernel maintainers -- which the exception of you --
who hang out  in the middle of the process rather than
at the top of the tree.

1. It is important that we be able (and encouraged, not discouraged)
to track the top of tree as closely as we have time to handle.
Divergence and conflicts are best handled as soon as they are noticed
and can be a huge pain if left to fester and discovered
only when it is time to push patches upstream.
Plus, tracking the top of tree means we force more folks to
track the top of tree, and so it gets more testing.  This is goodness.

Earlier in your release cycle when changes are appearing faster,
my need/desire to sync is greater than later in the cycle when changes
are smaller and infrequent.  On average, I think that one sync/day
from upstream is an entirely reasonable frequency.

2. It is also important that we be able to cherry pick individual patch=
es
in our trees so that they don't block each other from going upstream.
Tony's using-topic-branches.txt above is the best way I know of doing t=
hat.
I think it is a big improvement over the bk model since I can have a si=
mple
branch for each patch or group of patches rather than an entire reposit=
ory
dedicatd to each.  But for this to work, I need to be able to update
any and all of the topic branches from upstream, and to merge them with
each other -- just like I could with BK.  Otherwise they become "dated"
in the time they were first integrated, and it is not convenient to do
simple apples/apples comparisons that are needed to debug and test.

I'm probably a na=EFve git user -- but I expect I have a lot of company=
=2E
If there is a better way of using the tool to get the job done,
I'm certainly a willing customer with open ears.

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
