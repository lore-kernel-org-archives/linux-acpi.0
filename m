From: Norbert Preining <preining@logic.at>
Subject: regression from 2.6.23-rc2 to -rc3 BAT missing
Date: Mon, 13 Aug 2007 11:43:54 +0200
Message-ID: <20070813094354.GA4881@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:40061 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966069AbXHMJn4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Aug 2007 05:43:56 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all!

Starting with 2.6.23-rc3 the battery from my laptop (Acer TM3012) is
missing for linux (but not physically):

ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)

But it is definitely there and running, even when I unplug the AC power.

Any patch I can use to change this?

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
GLOSSOP (n.)
A rouge blob of food. Glossops, which are generally streaming hot and
highly adhesive invariably fall off your spoon and on to the surface
of your host's highly polished antique-rosewood dining table. If this
has not, or may not have, been noticed by the company present, swanage
(q.v.) may be employed.
			--- Douglas Adams, The Meaning of Liff
