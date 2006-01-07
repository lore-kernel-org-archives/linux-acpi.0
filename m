From: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sat, 7 Jan 2006 10:22:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601071017280.3169@g5.osdl.org>
References: <200512010305.43469.len.brown@intel.com> <200512060317.53925.len.brown@intel.com>
 <200512230042.17903.len.brown@intel.com> <200601071054.37741.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200601071054.37741.len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



On Sat, 7 Jan 2006, Len Brown wrote:
> 
> please pull this batch of trivial patches from: 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

Len,

I _really_ wish you wouldn't have those automatic merges.

Why do you do them? They add nothing but ugly and unnecessary history, and 
in this pull, I think almost exactly half of the commits were just these 
empty merges.

There's just no point, except to make the history harder to read.

So please stop it. You have some of the ugliest history around, and it's 
all just because you have some automated process that merges unnecessarily 
all the time.

If you do merges because you want to _test_ the development with a merged 
tree, that doesn't have to happen in the development branch itself. Nobody 
else cares about such a merge except the tester (unless the test fails of 
course, and you need to fix up the result - at which point it's not an 
automated merge any more).

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
