From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2 4/4] remove include asm/acpi.h in process_driver.c
Date: Mon, 4 Feb 2013 21:42:38 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1302042142280.31498@chino.kir.corp.google.com>
References: <1360031838-26898-1-git-send-email-lig.fnst@cn.fujitsu.com> <1360031838-26898-5-git-send-email-lig.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360031838-26898-5-git-send-email-lig.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: liguang <lig.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 5 Feb 2013, liguang wrote:

> process_driver.c include linux/acpi.h which already
> include asm/acpi.h, so remove it.
> 
> Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>

Acked-by: David Rientjes <rientjes@google.com>
