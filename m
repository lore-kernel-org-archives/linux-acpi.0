From: Dave Jones <davej@redhat.com>
Subject: systemd, fpdt and /dev/mem
Date: Mon, 10 Nov 2014 16:21:42 -0500
Message-ID: <20141110212142.GA2337@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46346 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752444AbaKJVVt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Nov 2014 16:21:49 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sAALLn1B002194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2014 16:21:49 -0500
Received: from gelk.kernelslacker.org (ovpn-113-96.phx2.redhat.com [10.3.113.96])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sAALLhVk001940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2014 16:21:49 -0500
Received: from gelk.kernelslacker.org (localhost [127.0.0.1])
	by gelk.kernelslacker.org (8.14.8/8.14.7) with ESMTP id sAALLhlV002754
	for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2014 16:21:43 -0500
Received: (from davej@localhost)
	by gelk.kernelslacker.org (8.14.8/8.14.8/Submit) id sAALLgTh002753
	for linux-acpi@vger.kernel.org; Mon, 10 Nov 2014 16:21:42 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I just noticed systemd has started doing this:

[ 3228.978745] Program systemd tried to access /dev/mem between 30a48000->30a48008.

After some investigation, it seems that it's reading
/sys/firmware/acpi/tables/FPDT to get a pointer, and then trying to read
that address using /dev/mem.  Asides from the grossness of grovelling around in
memory, given it's too late to stop exporting pointers in sysfs objects,
should there perhaps be a better way to export the data the FPDT is
pointing at ?

Or should some part of acpi be reserving the memory range it points to,
so that the /dev/mem driver doesn't freak out ?

Curiously, the address it points to is in this range..
  302b5000-3129dfff : Kernel bss

Which makes me wonder what exactly it's reading.

	Dave

