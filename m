From: Nate Lawson <nate@root.org>
Subject: Re: acpi-ca reports \_SB as a device
Date: Mon, 10 Jan 2005 13:03:27 -0800
Message-ID: <41E2ED9F.1080602@root.org>
References: <971FCB6690CD0E4898387DBF7552B90E3900E6@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-freebsd-acpi@freebsd.org>
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E3900E6@orsmsx403.amr.corp.intel.com>
List-Unsubscribe: <http://lists.freebsd.org/mailman/listinfo/freebsd-acpi>,
	<mailto:freebsd-acpi-request@freebsd.org?subject=unsubscribe>
List-Archive: <http://lists.freebsd.org/pipermail/freebsd-acpi>
List-Post: <mailto:freebsd-acpi@freebsd.org>
List-Help: <mailto:freebsd-acpi-request@freebsd.org?subject=help>
List-Subscribe: <http://lists.freebsd.org/mailman/listinfo/freebsd-acpi>,
	<mailto:freebsd-acpi-request@freebsd.org?subject=subscribe>
Sender: owner-freebsd-acpi@freebsd.org
Errors-To: owner-freebsd-acpi@freebsd.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: acpi@FreeBSD.org, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Ok, your rationale seems sound.  We'll keep the workaround of skipping 
such namespace system objects when scanning from the root.

-Nate

Moore, Robert wrote:
> For _SB_, this allows the _SB_._INI method to be run.
> 
> For _TZ, this allows notifies on the _TZ object.  Some ASL code does
> this.
> 
> 
> 
>>-----Original Message-----
>>From: Nate Lawson [mailto:nate@root.org]
>>Sent: Saturday, January 08, 2005 1:05 AM
>>To: ACPI Developers
>>Cc: acpi@FreeBSD.org
>>Subject: acpi-ca reports \_SB as a device
>>
>>If you call AcpiGetType on \_SB, you get "device" and \_TZ gives
>>"thermal".  I don't think this is valid since these are system scopes,
>>not devices and thermal zones.
>>
>>I found this while testing a patch that scans the whole namespace (\)
>>for devices.  It turns out some systems put PCI link devices (PNP0C0F)
>>in \, so we weren't probing them.
