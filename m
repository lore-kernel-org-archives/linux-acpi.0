From: Kamal Mostafa <kamal@canonical.com>
Subject: [RFC PATCH 0/2] i915 brightness control
Date: Wed,  2 Jun 2010 15:11:40 -0700
Message-ID: <1275516702-27090-1-git-send-email-kamal@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:49368 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758641Ab0FBWMA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2010 18:12:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc: Kamal Mostafa <kamal@canonical.com>

Requesting comments on this idea (proposed by Matthew Garrett) and my
implementation.  Note especially the KNOWN PROBLEM with a "GM45" GPU.

 -Kamal

.......

BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/568611

In order to avoid the often-dysfunctional native acpi brightness control
methods, a new acpi_brightness_hook interface is made available.

The i915 driver uses the new hook to take over brightness control.
Boot with i915.brightness=0 to disable.

KNOWN PROBLEM:
  - i915 opregion brightness control silently fails on GM45 (pci-id 0x2a42)

[RFC PATCH 1/2] acpi/video: acpi_brightness_hook API
[RFC PATCH 2/2] drm/i915: override acpi brightness control

