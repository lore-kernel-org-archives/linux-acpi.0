From: =?windows-1252?Q?Robert_W=F6rle?= <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Subject: Re: ACPI Patch How to ???
Date: Tue, 08 Oct 2002 13:21:22 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DA2BFB2.8080104@symplon.com>
References: <000001c26eba$136b5990$0700a8c0@Lapi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: T.Hubbert-Mmb7MZpHnFY@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

untar it ... copy it to your kernel source directory
then
patch -p1 <THIS_IS_THE_PATCH_FILE 2>out

reconfigure kernel
and make it

T.Hubbert-Mmb7MZpHnFY@public.gmane.org schrieb:

> Hi!
>
> I like to patch my Kernel 2.4.19 but i am a newbie and I don’t know 
> what to do with a .diff file. Can someone help me please?
>
> With a step for step answere?
>
> Thx
>

-- 
_____________________________________
*Robert Wörle
Linux | Embedded Device*
*
Symplon AG*

*...touch the internet*

phone: +49 89 552 999 35
fax: +49 89 552 999 10
email: robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org <mailto:robert.woerle@symplon.com>
web: www.symplon.com <http://www.symplon.com/>

_____________________________________



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
