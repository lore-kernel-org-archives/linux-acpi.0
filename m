From: Borislav Deianov <borislav@users.sourceforge.net>
Subject: ibm-acpi-0.10
Date: Sun, 16 Jan 2005 15:41:08 -0800
Message-ID: <20050116234108.GK25275@aero.ensim.com>
References: <20040916102610.GU20883@aero.ensim.com>
Reply-To: linux-thinkpad@linux-thinkpad.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-thinkpad-admin@linux-thinkpad.org>
Content-Disposition: inline
In-Reply-To: <20040916102610.GU20883@aero.ensim.com>
Sender: linux-thinkpad-admin@linux-thinkpad.org
Errors-To: linux-thinkpad-admin@linux-thinkpad.org
List-Help: <mailto:linux-thinkpad-request@linux-thinkpad.org?subject=help>
List-Post: <mailto:linux-thinkpad@linux-thinkpad.org>
List-Subscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=subscribe>
List-Unsubscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=unsubscribe>
List-Archive: <http://mailman.linux-thinkpad.org/pipermail/linux-thinkpad/>
To: linux-thinkpad@linux-thinkpad.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi,

It's been a couple of months and ibm-acpi was getting stale.
Especially with module parameters not working in 2.6.10, it was really
starting to stink up was the house... :-). So there you go, an update:

This is the 10th - oh let's call it beta - release of my ACPI driver
for IBM Thinkpad laptops. The features currently supported are:

	- Fn key combinations
	- Bluetooth enable and disable
	- video output switching, expansion control	
	- ThinkLight on and off
	- limited docking and undocking
	- UltraBay eject
	- CMOS control
	- LED control
	- ACPI sounds
	- Experimental: temperatures and fan speed
	- Experimental: embedded controller register dump

Changes since 0.8 (the version included in 2.6.10):

        - support for the 570, R30 and R31
        - ultrabay support for the A22p and A3x
        - drop experimental status from cmos, led and beep functions
        - fix module parameter passing
        - modified blank.sh should work with X on Debian and Fedora
        - default radio.sh script uses ipw2100 RF kill switch
        - default blank and hibernate events use the swsusp2 hibernate.sh
        - experimental temperatures and fan speed
        - experimental embedded controller register dump

The major new experimental feature is the temperature and fan speed
display. Some models (T and X series, maybe others) can show several
temperature readings (in addition to CPU temperature) and the current
fan speed. Three models (X31, X40 and 570) can control the fan speed
to a certain degree. See the README for the full details.

I still have a few things in my backlog, namely support for the 240,
600e, 770x and G41. Coming soon, I just needed to get something out
the door (I've been sitting on the 0.10 stuff for a while...).

http://ibm-acpi.sf.net/

Enjoy,
Boris
-- 
The linux-thinkpad mailing list home page is at:
http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad
