From: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>
Subject: Re: Keybaord and power button.
Date: Fri, 20 Jun 2003 09:53:50 -0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <01a101c3373d$99990160$3746028e@bio.dfo.ca>
References: <004401c334c3$1dce6b00$b8d21b2b@ADACHIPC>
 <0fa701c336dd$a2448e20$2a0806c0@wiproxcoio3398>
Mime-Version: 1.0
Content-Type: text/plain;	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: "siva" <sivakumar.subramani-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org>
>
> I have doubt regarding the power button.
> With out keyboard connected to the linux machine, Is it possible to do
> gracefull shutdown of my machine by just pressing the Power button.

Usually.  If you have ACPI enabled in the kernel, and you install the acpid
daemon, acpid monitors /proc/acpi/events and, by default, shuts the system down
with  your standard shutdown sequence on a short button press (ie, less than 4
seconds).  ACPI doesn't do this itself, it just sends events and lets something
else choose how to handle them.  Note, the acpid script may need to be tweaked,
as it doesn't necessarily know the correct names of the button events.

In future, please address questions like this to the
acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org list.



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
