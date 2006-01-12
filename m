From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Thu, 12 Jan 2006 16:10:51 +0000
Message-ID: <tnxirspo29g.fsf@arm.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.64.0601081111190.3169@g5.osdl.org>
	<20060108230611.GP3774@stusta.de>
	<Pine.LNX.4.64.0601081909250.3169@g5.osdl.org>
	<20060110201909.GB3911@stusta.de> <20060112013706.GA3339@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060112013706.GA3339-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> (Greg KH's message of "Wed,
 11 Jan 2006 17:37:06 -0800")
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, Jan 10, 2006 at 09:19:09PM +0100, Adrian Bunk wrote:
>> 
>> I am using the workaround of carrying the patches in a mail folder, 
>> applying them in a batch, and not pulling from your tree between 
>> applying a batch of patches and you pulling from my tree.
>
> Ick, I'd strongly recommend using quilt for this.  It works great for
> just this kind of workflow.

Or StGIT :-). Similar workflow (and similar commands) but better
integrated with GIT and better at dealing with conflicts since it uses
a three-way merge when pushing patches rather than applying them with
"patch".

-- 
Catalin
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
