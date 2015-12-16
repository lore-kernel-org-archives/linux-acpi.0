From: Al Stone <ahs3@redhat.com>
Subject: question on possible functionality...
Date: Tue, 15 Dec 2015 17:20:22 -0700
Message-ID: <5670AE46.1000107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46311 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754395AbbLPAUW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Dec 2015 19:20:22 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id B6395AA0DB
	for <linux-acpi@vger.kernel.org>; Wed, 16 Dec 2015 00:20:22 +0000 (UTC)
Received: from fidelio.ahs3 (ovpn-113-60.phx2.redhat.com [10.3.113.60])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tBG0KMDq031232
	for <linux-acpi@vger.kernel.org>; Tue, 15 Dec 2015 19:20:22 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

Howdy.

I have run into a couple of cases now where is would like to do something
like the following:

   $ iasl --acpi-version=5.1 apic.asl

to build a 5.1-compliant FADT, as compared to:

   $ iasl apic.asl

which always expects a very recent definition of the tables being defined.

Is anyone working on such a thing?  Or has it been contemplated in the past
and discarded for some reason?

Thanks.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
