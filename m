From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: How do I measue latency?
Date: 01 Aug 2002 14:57:51 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1028210271.15022.14.camel@irongate.swansea.linux.org.uk>
References: <3D48B4D3.1050109@folkwolf.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3D48B4D3.1050109-Pn2JTpibVOrk1uMJSBkQmQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Johnathan Hicks <thetech-Pn2JTpibVOrk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2002-08-01 at 05:10, Johnathan Hicks wrote:
> ASUS was lazy when crafting the ACPI tables for my A7M266-D motherboard, and 
> set the C2 and C3 latency values to 101 and 1001 respectivley to disable them. 
> I know that ACPI doesn't do C2/C3 on SMP yet, but I would like to be be able 
> to measure some real values to insert in the FADT(FACP?) for when it can be 
> used. Both measuring and inserting into that table are possible right?
> As a side note, they goofed on the _S3_ object and wrote S_3_ instead in the DSDT.

The current -ac tree has a non ACPI power management module that works
on this board, if that helps. Its not perfect but -ac6 will have the
updated one



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
