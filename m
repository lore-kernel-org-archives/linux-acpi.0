From: Borislav Deianov <borislav@users.sourceforge.net>
Subject: ibm-acpi-0.2
Date: Sat, 14 Aug 2004 14:12:47 -0700
Sender: linux-thinkpad-admin@linux-thinkpad.org
Message-ID: <20040814211247.GS20883@aero.ensim.com>
References: <20040810080826.GD28939@aero.ensim.com>
Reply-To: linux-thinkpad@linux-thinkpad.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-thinkpad-admin@linux-thinkpad.org>
Content-Disposition: inline
In-Reply-To: <20040810080826.GD28939@aero.ensim.com>
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

This is the second alpha release of my ACPI driver for IBM ThinkPad
laptops. The features currently supported are:

	- Fn key combinations
	- Bluetooth enable and disable
	- limited docking and undocking

So far, it has been tested on several T and X series ThinkPads. I
appreciate any user reports, either successful or unsuccessful. Please
see the included README for more information.

Changes since 0.1:

	- fixed problems preventing insmod on the T series and the X20
	- implemented bluetooth enable/disable
	- hotkey events are disabled by default, need explicit enable
	- fixed compilation problem on vanilla 2.6.7
	- dropped fan control, was useless in its current state 

(Sorry, no web page yet. One thing at a time.)

Thanks,
Boris


-- 
The linux-thinkpad mailing list home page is at:
http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad
