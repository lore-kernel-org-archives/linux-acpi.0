From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: standby resumes immediately in 2.6.0-test8
Date: Mon, 27 Oct 2003 10:52:46 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0310271050240.13116-100000@cherise>
References: <200310251516.50547.aviram@beyondsecurity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200310251516.50547.aviram-koYqR8i3DjZZkMgn48OZqdBPR1lH4CV8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Aviram Jenik <aviram-koYqR8i3DjZZkMgn48OZqdBPR1lH4CV8@public.gmane.org>
Cc: =?iso-8859-1?q?=C9ric=20Brunet?= <Eric.Brunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> It *does* look like something wakes the computer up immediately - but what can 
> it be?

Could you please do

# echo -n standby > /sys/power/state
# echo $?

and report whether that says '0' or '1'? 

Also, please send the output of 'cat /proc/acpi/sleep' ? If "S1"  is not
present, then your system does not support standby, and it will not work. 
Otherwise, we truly do have a bug..

Thanks,

	Pat



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
