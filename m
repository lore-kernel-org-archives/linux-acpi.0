From: <Stuart_Hayes@Dell.com>
Subject: Re: ACPI IPMI device with _CID getting wrong
	driver attached
Date: Thu, 21 Jan 2016 15:20:43 -0600
Message-ID: <959D45574D89AF41A9DADF6F446A2E9A50AEA4CD03@AUSX7MCPS310.AMER.DELL.COM>
References: <959D45574D89AF41A9DADF6F446A2E9A50AE8A4F6F@AUSX7MCPS310.AMER.DELL.COM>
	<569EA926.4050609@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-Reply-To: <569EA926.4050609@mvista.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: cminyard@mvista.com, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

> 
> On 01/19/2016 02:46 PM, Stuart_Hayes@Dell.com wrote:
> > I'm having a problem on a number of systems where the IPMI driver isn't able
> to find the ACPI IPMI device.
> >
> > This is happening because the ACPI scan is attaching the acpi_pnp handler to
> the ACPI IPMI device, which is happening because the IPMI device has a _CID of
> PNP0C01 in addition to an _HID of IPI0001.  This is a problem because
> acpi_scan_attach_handler() doesn't know about the IPMI drivers (ipmi_si /
> ipmi_ssif), which don't register as PNP or ACPI drivers, but instead expect the
> ACPI scan find no applicable driver and thus create a platform device.
> 
> I recently pulled out the pnp code in ipmi_si in favour of a platform device.  The
> trouble was that you couldn't register both the ipmi_si and ipmi_ssif driver with
> IPI0001 (even though they were in different
> spaces) because IPI0001 was hard-coded into the acpi_pnp tables.  This fix
> prevented having to update a lot of firmware.
> 
> Plus I was under the impression that this was the right thing to do, anyway.
> Perhaps it wasn't, but I didn't get a comment from the linux-acpi list when I
> submitted it (twice).
> 
> > This could be fixed pretty easily by modifying acpi_scan_attach_handler() to
> make it return 0 without attaching a handler to devices that have a _HID of
> IPI0001 when the kernel has an IPMI driver available (if, say, CONFIG_IPMI_SI,
> CONFIG_IPMI_SI_MODULE, CONFIG_IPMI_SSIF, or
> CONFIG_IPMI_SSIF_MODULE are defined)... but would this be accepted?
> 
> That sounds like a bad hack to me.
> 

I kind of agree.

> >    Or is this something that will require reworking the IPMI drivers?  Or is there
> another way?
> 
> The question in my mind is why the IPMI device has a _CID of PNP0C01 (or
> is it PNP0c01?  That's the only thing I found.).    From what I can tell
> from the spec, PNP0c01 is a "system board", and Linux has it as a "memory
> controller", neither of which is really applicable.
> 
> But I admit that I don't know very much about these things.  I believe the right
> place to fix this is the driver, if we can.  I'm hoping for a simple solution.
> 
> -corey

The _CID of PNP0C01 was added to this device so that operating systems without IPMI support would still reserve its resources.  I think the reasoning was that the OS would attach a driver for the _HID of IPI0001 if one exists, and would only fall back to the _CID of PNP0C01 if the OS didn't have anything for IPI0001.  Unfortunately, it doesn't work that way in the linux kernel, since the PNP driver for the _CID will take priority over something that requires a platform device to be created.

I'll give it some thought.  A "whitelist" for creating platform devices (like I believe used to exist in acpi_platform.c) would, I think, take care of this, but that was removed a while back in favor of just making a platform device if no other driver was found...





------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
