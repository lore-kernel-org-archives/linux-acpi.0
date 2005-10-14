From: "Bjorn Helgaas" <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [RFC]convert ACPI driver model to Linux driver model -
     takes 2
Date: Thu, 13 Oct 2005 21:21:00 -0600 (MDT)
Message-ID: <34445.24.9.204.52.1129260060.squirrel@mail.cce.hp.com>
References: <200510131443.47844.bjorn.helgaas@hp.com>
    <1129252436.3948.12.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1129252436.3948.12.camel-ECwVeV2eNyQD0+JXs3kMbRL4W9x8LtSr@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> On Fri, 2005-10-14 at 04:43 +0800, Bjorn Helgaas wrote:
>> You now have both 'acpi_driver' and 'acpi_phys_driver' (and
>> 'acpi_device' and 'acpi_phys_device').  What exactly is the
>> distinction?  Is the distinction necessary?  Can you just stuff
>> the generic device stuff into 'struct acpi_device' itself?

> Devices in ACPI bus use acpi_phys_driver, other devices use acpi_driver=
.

I'm sorry to be dense, but this doesn't help me.  What do you
mean by "devices in ACPI bus" as opposed to other ACPI devices?

Let's say I want to write a driver for something in ACPI, like
a fan.  How do I decide whether to use acpi_phys_driver or
acpi_driver?

Do you mean that I can use either one, and that you want to
migrate drivers from acpi_driver to acpi_phys_driver over time?

If that's the case, I think we should end up with acpi_driver,
not acpi_phys_driver, because "phys" doesn't tell me anything
useful.  And there aren't very many ACPI drivers, so I don't
really see the problem with just moving them all at once.




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
