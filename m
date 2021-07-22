Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4BBC6377D
	for <linux-acpi@archiver.kernel.org>; Thu, 22 Jul 2021 09:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333436128A
	for <linux-acpi@archiver.kernel.org>; Thu, 22 Jul 2021 09:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhGVJJk (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 22 Jul 2021 05:09:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231255AbhGVJJk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Jul 2021 05:09:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A848861244;
        Thu, 22 Jul 2021 09:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626947415;
        bh=5nxov8ciV1tfLgw1o3KidC/AG7DmWvz/Jsf5svr9jzs=;
        h=From:To:Cc:Subject:Date:From;
        b=Cm8nE1/+TevcInwy+rn1B4+T5kVqAqTToUucYXWnerFGM2OTi+341mhrug0MILyKv
         h8yEojyplk3+LOL4qcHM/GwFDf8ppmWWlQF7mZzjBgqOEj6mgT5gGhmZgeu7itteuq
         STubEdS4MhdXCz+cAhSaz24CStCSAIhZt19+9O6URK/G0M3f5AFv315U4+UH+MlQhM
         ypYq/o2V2cdxN+A2SdQpT04BvjZ66gh+9giRFNmvjBSRdynd68JDSWlsl88Sjw9vGH
         DukwKI3tpCLtxUiEWogBreNm6inVVlYG5nM6GyZqTc9t4eYqIO0eH222FdR+JqMCWq
         +JF3xjLNGUw5Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6VLD-008lGb-AO; Thu, 22 Jul 2021 11:50:07 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, kvm@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/3] Get rid of some undesirable characters
Date:   Thu, 22 Jul 2021 11:50:00 +0200
Message-Id: <cover.1626947264.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jon,

While rebasing my docs tree, I noticed that there are three remaining
patches from my past series that replace some UTF-8 chars by ASCII
ones that aren't applied yet. Not sure what happened here.

Anyway, those are the missing ones.

Mauro Carvalho Chehab (3):
  docs: sound: kernel-api: writing-an-alsa-driver.rst: replace some
    characters
  docs: firmware-guide: acpi: dsd: graph.rst: replace some characters
  docs: virt: kvm: api.rst: replace some characters

 .../firmware-guide/acpi/dsd/graph.rst         |  2 +-
 .../kernel-api/writing-an-alsa-driver.rst     |  2 +-
 Documentation/virt/kvm/api.rst                | 28 +++++++++----------
 3 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.31.1


