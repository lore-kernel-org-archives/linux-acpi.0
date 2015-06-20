From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ACPI / video: Run _BCL before deciding registering backlight
Date: Sat, 20 Jun 2015 15:26:39 +0300
Message-ID: <20150620122639.GA22193@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35880 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbbFTM1G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Jun 2015 08:27:06 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: aaron.lu@intel.com
Cc: linux-acpi@vger.kernel.org

Hello Aaron Lu,

The patch dce4ec2e452f: "ACPI / video: Run _BCL before deciding
registering backlight" from Oct 28, 2014, leads to the following
static checker warning:

	drivers/acpi/acpi_video.c:1659 acpi_video_run_bcl_for_osi()
	warn: calling kfree() when 'levels' is always NULL.

drivers/acpi/acpi_video.c
  1651  static void acpi_video_run_bcl_for_osi(struct acpi_video_bus *video)
  1652  {
  1653          struct acpi_video_device *dev;
  1654          union acpi_object *levels;
  1655  
  1656          mutex_lock(&video->device_list_lock);
  1657          list_for_each_entry(dev, &video->video_device_list, entry) {
  1658                  if (!acpi_video_device_lcd_query_levels(dev, &levels))
  1659                          kfree(levels);

kfree(NULL) is a no-op.  We could just remove the if statement here.

		list_for_each_entry(dev, &video->video_device_list, entry) {
			acpi_video_device_lcd_query_levels(dev, &levels);
		}

But then it's not clear to me the point of this loop is?

  1660          }
  1661          mutex_unlock(&video->device_list_lock);
  1662  }

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
