From: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Subject: Re: acpi data parser
Date: Mon, 14 Apr 2003 08:06:28 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030414080628.28ad1927.rddunlap@osdl.org>
References: <506C3D7B14CDD411A52C00025558DED60ED3BC@mtlex01.yok.mtl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <506C3D7B14CDD411A52C00025558DED60ED3BC-fvWgJdYFe9KA5yaOxrpyo0EOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: eli-VPRAkNaXOzVS1MOuV/RT9w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

hi,

It's described at
http://sourceforge.net/cvs/?group_id=36832

If that's not sufficient, let me know and I'll go thru the steps.

And I'll make some tarballs available one day this week, but for now
I'd suggest that you try to checkout the pmtools module.

~Randy


On Mon, 14 Apr 2003 18:02:58 +0300 Eli Cohen <eli-VPRAkNaXOzVS1MOuV/RT9w@public.gmane.org> wrote:

| Intel's disassembler does a segmentation fault when trying -g option. Can
| you send info on how to checkout pmtools from sourceforge?
| thanks
| 
| -----Original Message-----
| From: Randy.Dunlap [mailto:rddunlap-3NddpPZAyC0@public.gmane.org]
| Sent: Monday, April 14, 2003 5:04 PM
| To: Eli Cohen
| Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
| Subject: Re: [ACPI] acpi data parser
| 
| 
| On Mon, 14 Apr 2003 11:14:43 +0300 Eli Cohen <eli-VPRAkNaXOzVS1MOuV/RT9w@public.gmane.org> wrote:
| 
| | Hi,
| | is there any tool that can get the acpi data in a system and parse it in a
| | convenient way. Particularly the interrupt routing information.
| | thanks
| | Eli
| 
| Hi,
| 
| There are several such tools.
| 
| At the acpi sf project, there are "pmtools" in CVS (only at the
| moment).  See http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/acpi/ .
| 
| There is an Intel disassembler (IASL) that I haven't used.
| I think it's in the Unix Build Environment tarball here:
| http://developer.intel.com/technology/iapc/acpi/downloads.htm
| 
| and there could be another one soon.
| 
| HTH.
| --
| ~Randy   ["in English any noun can be verbed."  bah!]


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
