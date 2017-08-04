From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: [PATCH 0/2] Updated SPCR quirks for Moonshot/Mustang
Date: Fri,  4 Aug 2017 22:49:42 +0100
Message-ID: <20170804214944.3910-1-graeme.gregory@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, lho@apm.com, gregkh@linuxfoundation.org, jcm@redhat.com
List-Id: linux-acpi@vger.kernel.org

A couple of patches to build on the SPCR quirks support already upstreamed.

1 - Moonshot m400 cartridge has the same soc but ACPI tables have different
HPe specific headers so extend quirk to understand those too.

2 - Relevant vendors do not seem to be working on DBG2/SPCR update for
situation where the clock is unknown. We want these machines to boot with
console initialised from SPCR before I die of old age so use the previous
quirk handling to also handle the clock problem as well.

Thanks

Graeme
