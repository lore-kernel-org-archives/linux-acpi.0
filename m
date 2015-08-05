From: Al Stone <ahs3@redhat.com>
Subject: Re: [RFC PATCH] Exporting extra tables for machines without /dev/mem
Date: Wed, 5 Aug 2015 14:25:06 -0600
Message-ID: <55C27122.8040604@redhat.com>
References: <1437485468-17107-1-git-send-email-graeme.gregory@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437485468-17107-1-git-send-email-graeme.gregory@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 07/21/2015 07:31 AM, Graeme Gregory wrote:
> Hi,
> 
> I thought I would send this patch as an RFC. It is something I did when
> another linaro engineer was modifying acpica-tools to not require /dev/mem.
> 
> It exports the 3 tables that are not currenly exported in sysfs.
> 
> Currently I do not think there is any user of this because acpica-tools can
> can recover the information in the other tables without these three being
> exported, fwts also works fine without the patch so the only use case I have
> is the vague "might be useful for debug"

Right -- and I personally would like to have that debug use case.  AFAICT,
the RSDP and RSDT/XSDT are recreated by acpidump; i.e., based on knowledge
of the mapped tables, acpidump builds what it believes these tables should
look like.  But, the /dev/mem mappings would give me what ACPI is actually
using (what was directly passed to the kernel).  Should there be a bug in
table mapping or ACPI startup, this info might help.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
