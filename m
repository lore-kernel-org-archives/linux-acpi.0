From: "JP Mercury" <swirlee-HptHbbG/L9RWk0Htik3J/w@public.gmane.org>
Subject: Re: Averatec laptop- acpi_power_off hang
Date: Thu, 3 Feb 2005 10:17:58 -0700
Message-ID: <20050203171758.M86895@stickist.com>
References: <20050202214755.M81868@stickist.com> <Pine.LNX.4.60.0502031522440.4161@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
In-Reply-To: <Pine.LNX.4.60.0502031522440.4161-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 3 Feb 2005 15:23:14 +0100 (CET), liste wrote
> Salut Jan,
> On Wed, 2 Feb 2005, JP Mercury wrote:
> > Now I'd like to tackle the stubborn problem of powering off. Linux shuts down
> > but after acpi_power_off is called, it hangs. I tried the noapic, nolapic
> > kernel options as suggested for some other laptops- no go. Now I'm wondering,
> > could this be another DSDT problem?
> did you also try it without RTC? There was something with the
> realtimeclock that might prevent a power-off, if I remeber correctly.

Without RTC seems to make no difference.

Thanks for your suggestion.
-Mercury



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
