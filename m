From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: 2001-(Ali chipset)mainboard with no ACPI because "from '97 and too old"!
Date: Fri, 10 Oct 2003 10:30:42 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031010083042.GL11391@poupinou.org>
References: <200310092108.15747.blaisorblade_work@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200310092108.15747.blaisorblade_work-whZMOeQn8C0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: BlaisorBlade <blaisorblade_work-whZMOeQn8C0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Oct 09, 2003 at 09:08:15PM +0200, BlaisorBlade wrote:
> The subject explains almost all. On my desktop, my mainboard (from 1st 
> mainboards, with an AMI bios, if I don't remember badly) appears, on boot, as 
> "from '97 and too old" so ACPI is disabled; see top of dmesg output (on 
> kernel 2.4.22). On some older version of the patch(I've used the -ck patchset 
> since kernel 2.4.20, and it included ACPI, and I've had it in the Mandrake 
> 9.0/9.1 kernel) my mainboard was correctly handled and ACPI didn't create any 
> problems. All required data is attached. Please address any question on Cc: 
> to me, since I'm not subscribed. Thanks.

Dmesg said:

<quote>
ACPI disabled because your bios is from 97                         and too old
You can enable it with acpi=force
</quote>

so reboot with kernel parameter acpi=force.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
