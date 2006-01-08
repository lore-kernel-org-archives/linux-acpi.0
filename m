From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Sun, 08 Jan 2006 12:58:44 +0000
Message-ID: <1136725124.2444.26.camel@localhost>
References: <20060107172446.GA3092@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <hal-bounces@lists.freedesktop.org>
In-Reply-To: <20060107172446.GA3092@srcf.ucam.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/hal>
List-Post: <mailto:hal@lists.freedesktop.org>
List-Help: <mailto:hal-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=subscribe>
Sender: hal-bounces@lists.freedesktop.org
Errors-To: hal-bounces@lists.freedesktop.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, desktop_portables@lists.osdl.org, hal@lists.freedesktop.org, gnome-power-manager-list@gnome.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 2006-01-07 at 17:24 +0000, Matthew Garrett wrote:
> Currently, there are three ways that a sleep hotkey may generate an 
> event:
> 
> 1) Exposed in DSDT as an ACPI object, generates an ACPI notification 
> event (the "normal" way)
> 
> 2) Uses hardware-specific ACPI driver, generates an ACPI notification 
> event. Not exposed in the DSDT in any standard way (ibm-acpi, 
> toshiba-acpi, panasonic-acpi)
> 
> 3) Generates a scancode, which is picked up by the kernel and turned 
> into a keycode (HP laptops work like this)
> 
> This is all quite horribly confusing, and makes life miserable for 
> userspace.

Wholeheartedly agree.

>  I would like to suggest the following standardisation:
> 
> a) Hal should assume that all hardware has a sleep key, since there's no 
> way to actually tell.
> 
> b) Events generated in cases (1) and (2) should, for now, be caught by 
> acpid (or something similar) and then fed back into the input layer via 
> uinput. This should be scancode 142, which will end up as X keycode 223.

Yes, I proposed something similar here
[http://www.nabble.com/ACPI-to-uinput-bridge-t409384.html] -- using HAL
and uinput to send the keys to user-programs.

> c) Most keyboards in case (3) will already send scancode 142. For 
> laptops, those that shouldn't should be remapped at boot time by 
> checking the system DMI information and consulting a lookup table.

Yes, perhaps using the existing HAL infrastructure with FDI lookup
tables? We already have a HAL addon for watching ACPI events, and doing
things like refreshing the battery values, and emitting conditions for
the common buttons (lid, sleep, power) -- we could just extend this code
in the HAL addon.

The HAL addon is well tested, and plays nice with acpid if required.

> Rationale:
> 
> Having one type of event rather than three makes it easier for userspace 
> coders. Choosing to do it through the input layer lets people take 
> advantage of pre-existing code for binding userspace events to keyboard 
> events, and is significantly easier to do than getting keyboard events 
> back to the ACPI layer. Keycode 142 is chosen because it's what 
> Microsoft uses, and so most manufacturers who have taken this approach 
> have copied them.

Can we not go further and define Dock/UnDock,
BrightnessUp/BrightnessDown, Hibernate, etc?

Richard.
