From: "Bjoern A. Zeeb" <bzeeb-lists-mt/InyFV0sMN6vK3N8ee0qxOck334EZe@public.gmane.org>
Subject: Re: ACPI (any version) hangs SMP system if enabled, different
 symptoms dep. on ver.
Date: Mon, 30 Sep 2002 20:30:29 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.BSF.4.44.0209302029590.427-100000@e0-0.zab2.int.zabbadoz.net>
References: <20020930141532.5f047f4a.eli.stair@mchsi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020930141532.5f047f4a.eli.stair-+MseY0pMZYIAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Eli Stair <eli.stair-+MseY0pMZYIAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 30 Sep 2002, Eli Stair wrote:

> ___2.5.39 - ACPI enabled or pci=noacpi
>
> With ACPI enabled, this is the end of the kernel messages then it hangs. There are also
> oopses from what looks like the scheduler, probably because of the new code in 2.5.39.
>
> Parsing Methods:...........................................................................
> Table [DSDT] - 306 Objects with 26 Devices 75 Methods 19 Regions
> ACPI Namespace successfully loaded at root c04e85bc

Patch sent for this a minute ago ...

-- 
Greetings

Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
