From: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Subject: Re: Daemon that handles ACPI
Date: Tue, 25 Mar 2003 18:33:13 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <32834.4.64.238.61.1048645993.squirrel@www.osdl.org>
References: <1048644460.2910.39.camel@base.torri.linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1048644460.2910.39.camel-NN61vRp3iFIP0m8IYG7BWw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: storri-rphTv4pjVZMJGwgDXS7ZQA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> I know that development is going great for doing ACPI inside the kernel.
> What I do not know is if there is a daemon that does work similar to apmd
> which handles apm stuff from the kernel. I see that there are two programs,
> acpid and ospmd, there for me to use. Unfortunately they are both going on
> being 5 months to a 1 year behind the present development if the dates of
> when they were placed on the web is true. Is that
> because they are already well-defined and as a user I just need to configure
> it? Or are they behind because developement of them has lagged the kernel
> development?

Yes, development of the ACPI userspace side has been lagging or ignored
for awhile now.  Andy Grover asked for someone to pick them/these/it/all
up a little over 1 week ago and I have volunteered to try to do that.

So far I have just collected the pieces and tried to build them.
I will be putting the pmtools package (from intel.com) at the sourceforge
project also.

The GUI part of ospmd never has worked and I'm not thrilled about it,
but I'll give it a shot.

If anyone out there wants to help/contribute etc., please holler.

Thanks,
~Randy





-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
