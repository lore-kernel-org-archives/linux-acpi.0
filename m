From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3]making ACPICA safe for suspend/resume - take 2
Date: Thu, 27 Jan 2005 17:13:31 +0800
Message-ID: <1106817211.15867.4.camel@sli10-desk.sh.intel.com>
References: <1106293737.19407.60.camel@sli10-desk.sh.intel.com>
	 <20050121095219.GA18373@elf.ucw.cz>
	 <1106704432.5756.11.camel@sli10-desk.sh.intel.com>
	 <20050126115804.GC10264@elf.ucw.cz>
	 <1106787682.9062.7.camel@sli10-desk.sh.intel.com>
	 <20050127080313.GA5749@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050127080313.GA5749-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-01-27 at 16:03, Pavel Machek wrote:
> > > why can't be the same done in code that calls
> > > device's suspend() method from PCI code? That would be smaller change,
> > > and we would not duplicate a lot of code.
> > This is good for pci_disable_device (suspend), but not for resume. We
> > must restore PCI config and then call pci_enable_device.
> 
> Ok, perhaps we need pci_resume_device() wrapper, then, which does
> pci_restore_config() now, but we can easily add pci_enable_device()
> there?
I agree. It's better all such things are doing on PCI core. Every device
driver just is doing the similar. Then we need a mechanism to know if a
device is really enabled (maybe check dev->driver) or it's a bus master.

Thanks,
Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
