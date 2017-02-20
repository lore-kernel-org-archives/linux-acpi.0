From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Generic device properties framework updates for v4.11-rc1
Date: Tue, 21 Feb 2017 00:42:34 +0100
Message-ID: <CAJZ5v0iT34PQEekT5MP4Lrz6t42x3c_98W7nhpnceXK28UZC8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f174.google.com ([74.125.82.174]:35962 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdBTXmf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Feb 2017 18:42:35 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 device-properties-4.11-rc1

with top-most commit d3e1b617ae20c459627f501b4bc55b1ea91f662b

 i2c: allow specify device properties in i2c_board_info

on top of commit d5adbfcd5f7bcc6fa58a41c5c5ada0e5c826ce2c

 Linux 4.10-rc7

to receive generic device properties framework updates for v4.11-rc1.

These allow built-in (static) device properties to be declared
as constant, make it possible to save memory by discarding
alternative (but unused) built-in (static) property sets and
add support for automatic handling of built-in properties to the
I2C code.

Thanks!

---------------

Dmitry Torokhov (4):
      device property: allow to constify properties
      device property: constify property arrays values
      device property: export code duplicating array of property entries
      i2c: allow specify device properties in i2c_board_info

---------------

 drivers/base/property.c  | 229 ++++++++++++++++++++++++++++++-----------------
 drivers/i2c/i2c-core.c   |  16 +++-
 include/linux/i2c.h      |   3 +
 include/linux/property.h |  19 ++--
 4 files changed, 177 insertions(+), 90 deletions(-)
