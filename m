From: Mattia Dongili <dongili-vcC760zL2fQ1GQ1Ptb7lUw@public.gmane.org>
Subject: Re: enabling ACPI on RH 8
Date: Tue, 8 Apr 2003 11:57:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030408115707.3a3d2cc8.dongili@supereva.it>
References: <DFDDBBFBAF6C634BAE34B5F175A29F0227F406@hasmsx403.iil.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <DFDDBBFBAF6C634BAE34B5F175A29F0227F406-DFHDMA+VBDpRVdoAopKfxth3ngVCH38I@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Polevoy, IgorX" <igorx.polevoy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 8 Apr 2003 11:09:52 +0300
"Polevoy, IgorX" <igorx.polevoy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> Hi,
> after adding kernel options with "append"  the following appeared
> in dmesg, reporting that ACPI was enabled OK: 
> 
> apm: BIOS version 1.2 Flags 0x0b (Driver version 1.16)
> apm: disabled on user request.
> Starting kswapd
> VFS: Diskquotas version dquot_6.5.0 initialized
>  tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully
> loaded
> Parsing
> Methods:...........................................................
> 59 Control Methods found and parsed (196 nodes total)
> ACPI Namespace successfully loaded at root c03bd640
> ACPI: Core Subsystem version [20011018]
                               ^^^^^^^^^^

this is an ancient acpi subsystem, you should try with a recent vanilla
kernel and a recent acpi patch from www.sf.net/projects/acpi 

--
mattia
  


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
