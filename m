From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Runlevel for Sleep?
Date: Fri, 13 Sep 2002 19:13:39 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020913171338.GC7096@elf.ucw.cz>
References: <Pine.LNX.4.44.0209071232170.1021-100000@cherise.pdx.osdl.net> <200209081126.g88BQjn05186@pfn1.pefnos> <3D7C5FDF.4FB4E759@otello.alma.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3D7C5FDF.4FB4E759-gmoNqwowlqBr8A+qpt3pXFzrSV/HdtiB@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Diego Zuccato <diego-gmoNqwowlqBr8A+qpt3pXFzrSV/HdtiB@public.gmane.org>
Cc: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> connections. What happens if you are suspending a db server (well,
> suspending a server is IMHO a really stupid thing, but...) and after

Why?

You bought new UPS for your server. How do you install it without
bringing machine down? Suspend to disk, rearrange power cables,
resume.

You have your server on UPS. Power died, and UPS is indicating 30
seconds to failure. What do you do? Suspend to disk.

Ethernet card in your server died. You want to replace it. Your
server is not hotplug capable. What do you do? Suspend to disk,
replace ethernet card, resume. If you are fast your users will not
even see broken connections.

[I've created FAQ section in Documentation/swsusp.txt; I'll put this
question/answer in there in next merge.]
								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
