From: takawata-l7ZBCLq5RC066kwqclu8Pg@public.gmane.org
Subject: Re: display interface?
Date: Thu, 05 Sep 2002 12:21:53 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209050313.MAA01092@axe-inc.co.jp>
References: <3D76C770.40807@prairienet.org>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Your message of "Thu, 05 Sep 2002 11:54:40 JST."
             <3D76C770.40807-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
Cc: takawata-yzSWc4HAx5xL9jVzuh4AOg@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In message <3D76C770.40807-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>, John Belmonte wrote:
>> this may be a dump question: is there a acpi interface to the laptop display
>?
>> Is it possible to make the display darker/lighter depending on the state of 
>battery?
>> 
>>      Joerg
>
>There is no standard interface under ACPI for this.  Vendors implement 

There is a spec for Display control on ACPI at ACPI spec 2.0 Appendex B,
though it seems to be  not so widely accepted.

But My ThinkPad i1620 AML code implements this, and I'm writing a driver
for acpi vga spec on FreeBSD.


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
