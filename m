From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Problems with ACPI, power btns
Date: Mon, 30 Sep 2002 02:16:16 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020930021616.C35@toy.ucw.cz>
References: <20020927092452.7003.qmail@webmail5.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020927092452.7003.qmail-rGs03M86+Jd1RbMNNJCVHYkgB36zAFJh@public.gmane.org>; from janx1-QOiod4cnrWAN+BqQ9rBEUg@public.gmane.org on Fri, Sep 27, 2002 at 09:24:52AM -0000
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: James Joseph <janx1-QOiod4cnrWAN+BqQ9rBEUg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I have patched my 2.4.18 kernel with acpi-20020918.  There was a 
> top-level Makefile.rej but other than that the kernel compiled 
> properly and with Debug statements, i think ACPI is initializing.  
> I have the following problems:-
> 
> 1) I wish to use the "Sleep" "Wake Up" and "Power" buttons, but 
> when i press them i get (in /var/log/messages):-

It seems those buttons are not handled by acpi; add them to keymap.
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.



-------------------------------------------------------
This sf.net email is sponsored by: DEDICATED SERVERS only $89!
Linux or FreeBSD, FREE setup, FAST network. Get your own server 
today at http://www.ServePath.com/indexfm.htm
