From: Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: ibm-acpi-0.1
Date: Tue, 10 Aug 2004 16:11:29 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040810231129.GN28939@aero.ensim.com>
References: <20040810080826.GD28939@aero.ensim.com> <pan.2004.08.10.10.18.05.651578@yahoo.com> <pan.2004.08.10.11.37.29.407984@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

On Tue, 10 Aug 2004 12:21:04 +0000 (UTC) Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> wrote:
> Some more feedback from my T41.

Thanks a lot, Paul, that was very helpful. It looks like I have some
work to do.

> If you want my dsdt, just tell me and I will send you privately,
> because PAN is not able to attach anything to news posts.  (maybe is
> not even possible).

If it's not too much trouble, I'd appreciate it. In the mean time, I'm
looking at a hacked one off http://acpi.sf.net, so it's not very
important.

> ibm_acpi: acpi_invokef(FAN9, d, ...) failed
> ibm_acpi: acpi_invokef(FANS, vddd, ...) failed

Interesting. It seems that the T41 has the fan presets but no methods
to use them. No standard ACPI fan device either. Does it actually have
a fan? :-) I don't think there's much I can do for now apart from
disabling the fan control.

> The hotkey is the only thing working right now, but not completely.
> Like I said before, the Fn+F5 should enable/disable the wlan AND the
> bluetooth, but with this acpi driver, the bluetooth is not enabled
> any more.

That was to be expected. The code for the hot keys usually does
something like this:

if hot key events enabled
	generate event
else
	invoke default hot key behaviour

In this case, the default behaviour is toggling bluetooth on and
off. This should be easy to fix, though - a /proc/acpi/ibm/bluetooth
control would allow you to toggle the state from the ACPI handler for
Fn-F5.

> > On a T41 it inserts in the kernel only if I replace _SB.GDCK with
> > _SB.PCI0.PCI1.DOCK.

I'll make it look for that. As Shaohua noted, though, I'm not yet
scanning the PCI bus on the dock.

> I saw that you use idectl for enabling the cdrom on the docking
> station. I also use idectl to enable my cdrom or secondary hard-disk
> in the UltraBay slim, but I have the following problems: DMA is not
> working any more for hdc after "idectl 1 rescan" After some rescan
> cycles I will have a lot of ide1 in /proc/ide/
>
> See http://bugme.osdl.org/show_bug.cgi?id=2261
>
> Do you have the same problems ?

Yes, although I hadn't noticed DMA was off. I found all these posts
saying that both IDE and ACPI hot plugging are basically not supported
yet, so I was happy to get docking and undocking with the CD drive
working at all...

Thanks,
Boris


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
