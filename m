From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: AW: [PATCH] Add CONFIG_ACPI_RELAXED_AML option
Date: 13 Dec 2002 11:05:24 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1039777524.25123.17.camel@irongate.swansea.linux.org.uk>
References: <B900970C7DD9474C972986EB3EC7C58F0D404A@andromeda.agcad.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B900970C7DD9474C972986EB3EC7C58F0D404A-PWLG29+z7hEKeIAE67mlpo2P0GrZ+RbP@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Herbert Nachtnebel <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>
Cc: NoZizzing OrDripping <nozizzingordripping-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2002-12-13 at 09:30, Herbert Nachtnebel wrote:
> That's a really bad idea! This size checks are identented to assure, that important data which accidently follows the buffer can't be overridden by brain dead bios coders. Now you allow buffer overflow injection into linux from the bios!
> These are serious bios faults, in my DSDT I had to extend a buffer by 128 bytes to avoid a buffer overflow! 
> The situation doesn't get better if we ignore such errors. We have to urge the manufacturers to correct the DSDT's. And the best way to do this is to recognise the faults and blame them.

Allocating 1 byte of slack, giving a loud warning about the problem and
erroring if we exceed the 1 byte of slack doesn't sound so bad though?



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
