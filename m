From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: [acpi-jp 2672] RE: acipca patches for Intel
Date: Wed, 17 Sep 2003 22:11:24 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030917215306.B13632@root.org>
References: <D3A3AA459175A44CB5326F26DA7A189C1C3D6F@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <D3A3AA459175A44CB5326F26DA7A189C1C3D6F-sBd4vmA9Se58QrAoInS571DQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-jp-tQe3ye839drMEhfIqW2wlg@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Therien, Guy" <guy.therien-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

My acpidump output is here:
   http://www.root.org/~nate/acpi/ibm-acpidump.asl.gz

You can easily see the problem since method _BST returns the value of
a call to _GBST.  Here is a link to my original message with dmesg output:
   http://home.jp.freebsd.org/cgi-bin/showmail/acpi-jp/2408

BTW, I am close to isolating a panic caused by resource lists (in this
case _CRS) overflowing the allocated buffer.

-Nate

On Wed, 17 Sep 2003, Moore, Robert wrote:
> Please send a listing of the _BST errors that appear on the IBM machines
> and the related DSDT.  This issue isn't really an ACPI 2.0 issue, it
> extends back to ACPI 1.0.  I'd like to solve this once and for all if
> possible.
>
> Bob
>
>
> This patch reverts part of 0619 to fix _BST errors on IBM thinkpads (and
> others.  It appears many ASL versions do not implement the alluded to
> 2.0C copy semantics.
>
> --- dsmthdat.c	Thu Jun 19 17:30:43 2003
> +++ /sys/contrib/dev/a.old/dsmthdat.c	Tue Apr 29 11:36:50 2003
> @@ -392,6 +392,7 @@
>  {
>      ACPI_STATUS             Status;
>      ACPI_NAMESPACE_NODE     *Node;
> +    ACPI_OPERAND_OBJECT     *NewDesc = Object;
>
>
>      ACPI_FUNCTION_TRACE ("DsMethodDataSetValue");
> @@ -410,17 +411,32 @@
>          return_ACPI_STATUS (Status);
>      }
>
>
>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
