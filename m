Return-Path: <SRS0=Qzs7=S2=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4779AC282CE
	for <linux-acpi@archiver.kernel.org>; Wed, 24 Apr 2019 09:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187DD2148D
	for <linux-acpi@archiver.kernel.org>; Wed, 24 Apr 2019 09:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K1G7u3+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfDXJu5 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:50:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46590 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfDXJu5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Apr 2019 05:50:57 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3O9o05U031690;
        Wed, 24 Apr 2019 09:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=OIuYEJY5fi7zxkGVxz0NBk5S0x+pCQdo4wBVV01eV/Y=;
 b=K1G7u3+NOgydJ4GbMiKurmUfE9yFIy2voRAGAfjESTRec8tjF4rTcWr9VE0gZhW8LFSY
 w0ff/JFiuIUI0daHl21MZLvJxX+Zv8QeN1JGS0OQDJEc9JEnlq5Ye8Hkp4KWA3+gdj9c
 Tfkdjzcshfb0vsLx+z43x0mqnWupTRKcMJI2PUM0wfBrWOXX1F0hEBXBrlgSImmby61U
 DSpagk5+cQTROHn+C4ygNY3Nptl5S7PZZl8o/woxl4wd6l6FrcBdkaP3Jcz5n6OPFLm7
 kjlfTClKwnuZldxjoaUMXgObYGR/BG9K6jmC5UBtxspTjXBjxDC01adrLALrH3KH+8lK yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2ryrxd1fdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 09:50:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3O9mW0h182354;
        Wed, 24 Apr 2019 09:48:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2s0fv3ftd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 09:48:54 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3O9mrDX015019;
        Wed, 24 Apr 2019 09:48:53 GMT
Received: from mwanda (/105.55.12.114)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Apr 2019 02:48:52 -0700
Date:   Wed, 24 Apr 2019 12:48:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dan.j.williams@intel.com
Cc:     linux-acpi@vger.kernel.org
Subject: [bug report] libnvdimm: control (ioctl) messages for nvdimm_bus and
 nvdimm devices
Message-ID: <20190424094845.GC15818@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=813
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904240083
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=839 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904240083
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello Dan Williams,

The patch 62232e45f4a2: "libnvdimm: control (ioctl) messages for
nvdimm_bus and nvdimm devices" from Jun 8, 2015, leads to the
following static checker warning:

	drivers/acpi/nfit/core.c:611 acpi_nfit_ctl()
	error: 'out_size' from user is not capped properly

drivers/acpi/nfit/core.c
   594          for (i = 0, offset = 0; i < desc->out_num; i++) {
   595                  u32 out_size = nd_cmd_out_size(nvdimm, cmd, desc, i, buf,
   596                                  (u32 *) out_obj->buffer.pointer,
   597                                  out_obj->buffer.length - offset);
   598  
   599                  if (offset + out_size > out_obj->buffer.length) {
                            ^^^^^^^^^^^^^^^^^
It looks like this addition could have an integer overflow bug.

   600                          dev_dbg(dev, "%s output object underflow cmd: %s field: %d\n",
   601                                          dimm_name, cmd_name, i);
   602                          break;
   603                  }
   604  
   605                  if (in_buf.buffer.length + offset + out_size > buf_len) {
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The comments suggest that this is safe.  I don't know the code.

   606                          dev_dbg(dev, "%s output overrun cmd: %s field: %d\n",
   607                                          dimm_name, cmd_name, i);
   608                          rc = -ENXIO;
   609                          goto out;
   610                  }
   611                  memcpy(buf + in_buf.buffer.length + offset,
   612                                  out_obj->buffer.pointer + offset, out_size);
   613                  offset += out_size;
   614          }
   615  

regards,
dan carpenter
