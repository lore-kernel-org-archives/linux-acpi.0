From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: [PATCH 0/3] Add AMBA bus probing support to ACPI
Date: Wed, 30 Sep 2015 11:38:47 +0100
Message-ID: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33045 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767AbbI3Kiz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Sep 2015 06:38:55 -0400
Received: by wiclk2 with SMTP id lk2so191271157wic.0
        for <linux-acpi@vger.kernel.org>; Wed, 30 Sep 2015 03:38:54 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, shannon.zhao@linaro.org

As discussed when Shannon Zhao sent a patch to add platform_device support
to pl061 driver. Russel and other maintainers prefered that ACPI learned
how to create AMBA devices rather than converting/adding platform_device
support to AMBA drivers.

http://comments.gmane.org/gmane.linux.ports.arm.kernel/431364

1) Adds basic AMBA device probing support to ACPI, it uses a whitelist of
device IDs as the number of AMBA devices is limited. Currently the two ids
present are those used in QEMU for arm64.

2) Adds the plumbing into ACPI probe sequence.

3) From ACPI pl011 is only defined (SBSA document) to be in SBSA mode which has
reduced functionality. There may be a better method to do this that I have
overlooked.

Thanks

Graeme

