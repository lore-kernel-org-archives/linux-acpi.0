From: Arend van Spriel <arend@broadcom.com>
Subject: ACPI_COMPANION equivalent in older kernels
Date: Wed, 10 Jun 2015 16:17:44 +0200
Message-ID: <55784708.60305@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:61075 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266AbbFJOTs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2015 10:19:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

For backporting a driver to 3.11 kernel I would like to know how to get 
same functionality as ACPI_COMPANION(). I did it like below, but would 
like to have some confirmation on it.

Regards,
Arend
--8<------------------------------------------------------------------
static inline
struct acpi_device *_acpi_get_companion(struct device *dev)
{
	struct acpi_device *adev;
	int ret;

	ret = acpi_bus_get_device(ACPI_HANDLE(dev), &adev);
	if (ret < 0)
		adev = NULL;

	return adev;
}
#define ACPI_COMPANION(dev)	_acpi_get_companion(dev)
