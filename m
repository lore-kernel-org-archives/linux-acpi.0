From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: RE: S3 Resume working, but IDE disk hung
Date: 09 Oct 2002 16:37:34 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1034177854.2065.58.camel@irongate.swansea.linux.org.uk>
References: <1DD88DDBBB83D6119C8C00096BB0408FCE495C@USAMCMS5>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1DD88DDBBB83D6119C8C00096BB0408FCE495C-CdvpJ7rTi0s@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Faraoni, Michael" <Michael.Faraoni-YwRvm6FT6jBDPfheJLI6IQ@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Andre Hedrick <andre-QA/0nRrxPJrNLxjTenLetw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2002-10-09 at 15:35, Faraoni, Michael wrote:
>  The suspend/resume in the piix.c is registered in PCI device structure and
> called through Device_Resume(), it would be nicer if the upper IDE layers
> would coordinate these activities.  When we resume from S3, we know that all

The pci layer may well be the right place to do this anyway. It will
bring the various layers up for you. There is also a good argument that
you want to provide your code as

      ide_pci_generic_resume()

in pci-setup or ide-lib and call that from the drivers, because someone
will eventually have a controller that needs different fixes. Making the
driver do the call to the library code makes that easy. The reverse
causes much pain




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
