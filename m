From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: [RFC PATCH] Exporting extra tables for machines without /dev/mem
Date: Tue, 21 Jul 2015 14:31:07 +0100
Message-ID: <1437485468-17107-1-git-send-email-graeme.gregory@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I thought I would send this patch as an RFC. It is something I did when
another linaro engineer was modifying acpica-tools to not require /dev/mem.

It exports the 3 tables that are not currenly exported in sysfs.

Currently I do not think there is any user of this because acpica-tools can
can recover the information in the other tables without these three being
exported, fwts also works fine without the patch so the only use case I have
is the vague "might be useful for debug"

So I ask the list for its opinions.

Graeme
