From: "Faraoni, Michael" <Michael.Faraoni-YwRvm6FT6jBDPfheJLI6IQ@public.gmane.org>
Subject: S3 Resume working, but IDE disk hung
Date: Fri, 04 Oct 2002 11:02:52 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1DD88DDBBB83D6119C8C00096BB0408FA9D2E6@USAMCMS5>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-return: allowed
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

 I have been able to get S3 mode to come back to prompt, but the IDE disk is
hung (drive light constantly on).  Running an app that isn't in disk cache
or that accesses the disk causes the app to hang, presumably blocked on I/O.
This indicates that the IDE drivers are not yet S3 suspend/resume capable
(the IDE controller/devices are not being restored properly), which I
expected at this stage.

 I am using an Intel Motherboard with an i810 chipset (using piix IDE PCI
driver), and 2.5.40 kernel with ACPI 20021002 diff applied.

 The IDE drivers seem to have some suspend/resume infrastructure. Does any
one know the direction that is being taken?  I am willing to help
implement/test, but want to know bigger picture/plan before starting (if
known?).

 I have looked into the present IDE suspend/resume, but they don't appear to
be called in S3 mode (my printk in ide-disk.c do_idedisk_resume() didn't
happen).  I kludged the piix.c file, adding a suspend and resume routine to
PCI device structure (which gets called).  In the resume I forced a call to
piix_config_drive_xfer_rate(), which does get the disk back to being useable
again, but I know this is in NO way the correct method :)

 Any info on direction or other help would be appreciated.


  Mike Faraoni



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
