From: Borislav Deianov <borislav@users.sourceforge.net>
Subject: ibm-acpi-0.3
Date: Tue, 17 Aug 2004 02:19:21 -0700
Sender: linux-thinkpad-admin@linux-thinkpad.org
Message-ID: <20040817091921.GI20883@aero.ensim.com>
References: <20040810080826.GD28939@aero.ensim.com> <20040814211247.GS20883@aero.ensim.com>
Reply-To: linux-thinkpad@linux-thinkpad.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-thinkpad-admin@linux-thinkpad.org>
Content-Disposition: inline
In-Reply-To: <20040814211247.GS20883@aero.ensim.com>
Errors-To: linux-thinkpad-admin@linux-thinkpad.org
List-Help: <mailto:linux-thinkpad-request@linux-thinkpad.org?subject=help>
List-Post: <mailto:linux-thinkpad@linux-thinkpad.org>
List-Subscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=subscribe>
List-Unsubscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=unsubscribe>
List-Archive: <http://mailman.linux-thinkpad.org/pipermail/linux-thinkpad/>
To: acpi-devel@lists.sourceforge.net, linux-thinkpad@linux-thinkpad.org
List-Id: linux-acpi@vger.kernel.org

Hi,

This is the third alpha release of my ACPI driver for IBM ThinkPad
laptops. The features currently supported are:

	- Fn key combinations
	- Bluetooth enable and disable
	- turning the LCD off, brightness control
	- ThinkLight on/off
	- limited docking and undocking

So far, it has been tested on several T, X and R series ThinkPads. I
appreciate any user reports, either successful or unsuccessful. Please
see the included README for more information.

Changes since 0.2:

	- fixed problems preventing insmod on the R40
	- implemented LCD brightness control and turning off
	- implemented ThinkLight on/off

I just noticed that turning the LCD off only works in X, not on the
console, at least for me. I'll need to look into this further.

Finally, a download URL:

http://bkernel.sf.net/tmp/ibm-acpi-0.3.tar.gz

Still no web page.

I'll be on vacation for the next three weeks, so I'll be a little slow
with replies to email. If you are replying to the lists, I'd
appreciate a CC, I'd see it sooner that way.

Boris
-- 
The linux-thinkpad mailing list home page is at:
http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad
