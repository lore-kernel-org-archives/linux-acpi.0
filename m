From: Borislav Deianov <borislav@users.sourceforge.net>
Subject: ibm-acpi-0.5
Date: Mon, 18 Oct 2004 02:21:17 -0700
Sender: linux-thinkpad-admin@linux-thinkpad.org
Message-ID: <20041018092117.GE17013@aero.ensim.com>
References: <20041018091946.GD17013@aero.ensim.com>
Reply-To: linux-thinkpad@linux-thinkpad.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-thinkpad-admin@linux-thinkpad.org>
Content-Disposition: inline
In-Reply-To: <20041018091946.GD17013@aero.ensim.com>
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

This is the fifth alpha release of my ACPI driver for IBM ThinkPad
laptops. The features currently supported are:

        - Fn key combinations
        - Bluetooth enable and disable
        - video output switching, video expansion control
        - ThinkLight on/off
        - limited docking and undocking
        - UltraBay device eject
	- experimental CMOS control
	- experimental LED control
	- experimental ACPI sounds

A compatibility table by model and feature is maintained on the web
site, http://ibm-acpi.sf.net/. I appreciate any success or failure
reports, especially if they add to or correct the compatibility table.
Please see the included README for more information.

Changes since 0.4:

	- thinklight support on A21e, G40, R32, T20, T21, X20
	- proc file format changed
	- video_switch command
	- experimental cmos control
	- experimental led control
	- experimental acpi sounds

The proc file format changed for several features in this release.
Please review the new file contents and update your acpid scripts as
necessary. The example scripts included in the distribution have also
been updated accordingly.

Please see the README about the three new experimental features and
how to enable them.

If there are no major problems, I intend to submit this release for
inclusion into the linux-acpi tree.

Boris

http://ibm-acpi.sf.net/
-- 
The linux-thinkpad mailing list home page is at:
http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad
