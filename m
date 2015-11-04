From: Alex Garnett <axfelix@gmail.com>
Subject: [PATCH v2] ACPI/osl: speedup grace period in acpi_os_map_cleanup
Date: Wed, 4 Nov 2015 09:29:36 -0800
Message-ID: <CACoWiSA=Hv+q68JEMvyX2-P+cWBr9tGPYrmznhfE-sAexVPPNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33221 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965550AbbKDR34 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Nov 2015 12:29:56 -0500
Received: by wmeg8 with SMTP id g8so116606817wme.0
        for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2015 09:29:55 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi folks,

Apologies for resending an old patch (by another contributor, not
myself), but it never received a response in the first go-round, and
now that we're back in a merge window, I'd love to get this regression
fixed:

https://www.marc.info/?l=linux-acpi&m=143853596924508&w=1

Best,
-alex
