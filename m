From: Ivan Gyurdiev <ivg2-HmMyXyqgL2CVc3sceRu5cw@public.gmane.org>
Subject: Re: 2.5.75 - ACPI and sound lockups
Date: Sun, 13 Jul 2003 06:02:49 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307130602.49710.ivg2@cornell.edu>
References: <Pine.LNX.4.33.0307131238520.561-100000@frog.athome>
Reply-To: ivg2-HmMyXyqgL2CVc3sceRu5cw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.33.0307131238520.561-100000-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sunday 13 July 2003 06:43, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> Salut Ivan,

salut

> my first look says, that IRQ 3,7,10 and 11 (which is the one, that bit
> you, I think) has to be level and not edge.
> As irq 11 is shared, this is no good!
>
> May you please get the information you provided for 2.5.74 for the
> 2.4-kernel you mentioned, too (including ACPI-version from
> /proc/acpi/info)?

You mean the 2.4 kernels, which I mentioned work fine?
Every 2.4 kernel I've tried with ACPI works ok (that's the 2.4 in-kernel code, 
no patches). Should I try the latest 2.4 kernel? 



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
