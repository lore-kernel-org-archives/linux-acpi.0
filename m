From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] int to bool conversion
Date: Mon, 26 Jan 2015 14:32:46 +0100
Message-ID: <2189735.DtT3OIbRBT@vostro.rjw.lan>
References: <20150122084941.GA14651@sloth> <1659960.ohcxabvmYi@vostro.rjw.lan> <54C5FB3F.6000803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54C5FB3F.6000803@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Lambert <lambert.quentin@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Shaohua Li <shaohua.li@intel.com>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, January 26, 2015 09:30:55 AM Quentin Lambert wrote:
> Sorry for the delay in answering ....
> 
> On 22/01/2015 17:18, Rafael J. Wysocki wrote:
> > On Thursday, January 22, 2015 09:49:41 AM Quentin Lambert wrote:
> >> These patches convert local variables from int to bool when relevant.
> > And what exactly is the need for that?  Does that fix any functional problems?
> >
> >
> It doesn't fix any functional problem. The point of this patch
> is to increase the code readability by lifting some of the ambiguities
> that appear when using an integer variable as boolean.
> 
> My understanding is that by explicitly using a boolean declaration
> when it is relevant it clearly informs the reader that the variable
> is going to represent a binary state. Moreover, using the keywords
> true and false help indicate that the variable will not be involved
> in any computation other than boolean arithmetic.

Well, in the new code, yes.  The existing code is a different matter though
and it doesn't actually hurt if you leave the ints where they are, so there's
no reason to make those changes.

If you change old code and the change is not trivial (eg. fixes of white space
or comments, or kernel messages etc.) and someone enounters a bug that may be
related to it, they will have to go through your changes to see if that's not
the source of the bug.  That's not really productive.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
