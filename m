From: Thomas Renninger <trenn@suse.de>
Subject: ACPI ec.c and ec_sys.c fixes
Date: Thu, 29 Jul 2010 22:08:43 +0200
Message-ID: <1280434125-11943-1-git-send-email-trenn@suse.de>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de, akpm@linux-foundation.org
List-Id: linux-acpi@vger.kernel.org

These apply on top of Matthew's platform driver linux-next branch.

One hunk of the EC port double registration fix, is a revert of
the patch where the problem got introduced:
git commit (platform driver's linux-next branch):
10da7c1b03753ecc0fe1a34608cc327f8c1c3630
ACPI: Register EC io ports in /proc/ioports

These patches are only needed for linux-next and should go in
through the platform driver's tree.

Thanks,

       Thomas
