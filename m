From: "Francesco P. Lovergine" <frankie-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: DSDT overriding by local table, any modularization possible?
Date: Wed, 14 Jul 2004 10:45:14 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040714084514.GD31097@ba.issia.cnr.it>
References: <BAY16-F36gjakzxHaMy000203af@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BAY16-F36gjakzxHaMy000203af-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 13, 2004 at 01:50:47PM -0300, Dino Klein wrote:
> Did you check the patch I made a while ago (january)?
> http://marc.theaimsgroup.com/?l=acpi4linux&m=107448387831707&w=2
> 
> // sales pitch begin
> It works by using an initramfs image to hold the initrd image and a 
> modified DSDT (other tables can also be placed in it, such as SSDT).
> // sales pitch end :)
> I haven't touched (or used) it for a while, so I don't know if boot 
> sequence procedure got changed since 2.6.1 to render it inoperable. If you 
> do try it, let me know if it doesn't work anymore.
> 

Interesting hack, it's tiny and clean enough to be considered for 
debian stock kernels. I'll do some tests.

-- 
Francesco P. Lovergine


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
