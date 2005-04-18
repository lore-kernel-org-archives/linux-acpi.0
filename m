From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: [tlinux-users:06884] Re: [ACPI] Portege 7010CT CPU speed
Date: Mon, 18 Apr 2005 13:31:07 -0500
Message-ID: <20050418183107.GA27407@dbz.icequake.net>
References: <20050412035916.GB7304@dbz.icequake.net> <20050415131757.GD2298@poupinou.org>
Reply-To: tlinux-users@linux.toshiba-dme.co.jp
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <tlinux-users-admin@linux.toshiba-dme.co.jp>
In-Reply-To: <20050415131757.GD2298@poupinou.org>
List-Software: fml [fml 4.0 STABLE (20021020/4.0.4_ALPHA)]
List-Post: <mailto:tlinux-users@linux.toshiba-dme.co.jp>
List-Owner: <mailto:tlinux-users-admin@linux.toshiba-dme.co.jp>
List-Help: <mailto:tlinux-users-ctl@linux.toshiba-dme.co.jp?body=help>
List-Unsubscribe: <mailto:tlinux-users-ctl@linux.toshiba-dme.co.jp?body=unsubscribe>
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: Ryan Underwood <nemesis-lists@icequake.net>, acpi-devel@lists.sourceforge.net, tlinux-users@linux.toshiba-dme.co.jp
List-Id: linux-acpi@vger.kernel.org


On Fri, Apr 15, 2005 at 03:17:57PM +0200, Bruno Ducrot wrote:
> 
> You hit the (in)famous 'toshiba return bug'.  That should be fixed with
> recent version of ACPI-CA (read: may not work with 2.6.11, but should
> work with upcomming 2.6.12).

I cloned linux-2.6 BK of 2.6.12-rc2, and then pulled ACPI 26-latest into
it.  Recompiled with stock Debian configuration.  The following problems
have been fixed for the 7010CT and were previously broken:

- CPU speed is now 300MHz instead of 150MHz
- ACPI IRQ routing is now working (pci=noacpi not necessary)
- hotplug picks up internal sound on the 'isapnp' bus as it should from
  the ACPI-PNP info.  Unfortunately opl3sa2 is blacklisted in default
  hotplug configuration; I haven't seen yet if it successfully loads the
  driver.

Unfortunately kernel 2.6.12-rc2 seems to have some bugs - for instance
unloading opl3sa2 module hangs the system entirely.  Furthermore, there
is an e100 ethernet which is enabled when the docking station is
connected at boot (hotplugging docking station does not work as with
windows).  This works initially, but after some time the transceiver
seems to stop responding.  Attempting to unload the driver first fails
and then oopses.  I'm not sure if this is the defective docking station
or a linux bug.  I only get to interact with this system once per month
or so, so it is hard to check.

Anyway, the ACPI problems seem to have been solved, so I'd like to see
the fix(es) into the main kernel soon.  Thanks!

-- 
Ryan Underwood, <nemesis@icequake.net>
