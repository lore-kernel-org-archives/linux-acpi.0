From: Borislav Deianov <borislav@users.sourceforge.net>
Subject: Re: ibm-acpi-0.2
Date: Sun, 15 Aug 2004 01:47:30 -0700
Sender: linux-thinkpad-admin@linux-thinkpad.org
Message-ID: <20040815084729.GX20883@aero.ensim.com>
References: <20040810080826.GD28939@aero.ensim.com> <20040814211247.GS20883@aero.ensim.com> <1092557960.10752.10.camel@mentorng.gurulabs.com>
Reply-To: linux-thinkpad@linux-thinkpad.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-thinkpad-admin@linux-thinkpad.org>
Content-Disposition: inline
In-Reply-To: <1092557960.10752.10.camel@mentorng.gurulabs.com>
Errors-To: linux-thinkpad-admin@linux-thinkpad.org
List-Help: <mailto:linux-thinkpad-request@linux-thinkpad.org?subject=help>
List-Post: <mailto:linux-thinkpad@linux-thinkpad.org>
List-Subscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=subscribe>
List-Unsubscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=unsubscribe>
List-Archive: <http://mailman.linux-thinkpad.org/pipermail/linux-thinkpad/>
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-thinkpad@linux-thinkpad.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Sun, Aug 15, 2004 at 02:19:21AM -0600, Dax Kelson wrote:
> 
> Does it work differently on older ThinkPads? Can I use your driver
> without messing up the already working Bluetooth enable/disable?

Yes, you can. When you first load the driver, Fn-F5 will continue to
work the same way. If you then enable hotkey events and set the mask
to include Fn-F5 (see the README for the full details), Fn-F5 will
instead generate an ACPI event. Using acpid, you can set a script to
run on this event. You can do whatever you want in the script,
including controlling Bluetooth via /proc/acpi/ibm/bluetooth.

Regards,
Boris
-- 
The linux-thinkpad mailing list home page is at:
http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad
