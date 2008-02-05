From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 4/5] ACPI: WMI: Add sysfs userspace interface
Date: Tue, 5 Feb 2008 22:59:24 +0000
Message-ID: <200802052259.25466.carlos@strangeworlds.co.uk>
References: <20080205021658.4422.83165.stgit@pacifica> <20080205021721.4422.58508.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from host-240-152.cust.aaawireless.net ([216.23.240.152]:39292 "EHLO
	mail.slackadelic.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756560AbYBEW72 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Feb 2008 17:59:28 -0500
In-Reply-To: <20080205021721.4422.58508.stgit@pacifica>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tuesday 05 February 2008 02:17:21 Carlos Corbacho wrote:
> Create a 'wmi' class, and populate it with a virtual device for each GUID.
> This also allows us to autoload WMI drivers based on GUID
> via MODULE_ALIAS.
>
> Under each GUID are a set of files that can be read and written to from
> userspace (these will be fully documented in a later patch).
>
> For now, the length of the GUID name/ directory is limited to 19
> characters, due to the current hardcoded limit on bus_id. When this is
> fixed, this can be changed in the code.

I'm starting to have some serious doubts about using sysfs for communicating 
with userspace (I'm happy with the class/ virtual device ID idea, and I don't 
see that being dropped, since it also solves the WMI autoloading problem 
quite neatly - but the extra sysfs files added on to allow userspace to 
interact with WMI are where I have a problem).

The problem is that a lot of the interactions with WMI are transactional - we 
pass something in, and we expect to get something out, and we don't want 
anything to happen in the middle to that data.

At the moment, this is the snippet of (Python) code I have to execute a WMI 
method from userspace (instance and method_id in this case are just integers, 
data_in and data_out can be any data structure, and are whatever the WMI 
method accepts & returns, respectively):

def evaluate_method(guid, instance, method_id, data_in, data_out):
	# Check that the instance is not bigger than the allowed maximum
	# The maximum is defined by the GUID entry in the DSDT
	instance_count_file = open(path + guid + "/instance_count", "r")
	
	if int(instance) > int(instance_count_file.read()):
		print "Instance is outside allowed maximum range"
		exit()
	
	instance_count_file.close()
	
	# Specify the instance we want to execute
	instance_file = open(path + guid + "/instance", "w")
	instance_file.write(instance)

	# Specify the method we want to execute
	method_id_file = open(path + guid + "/method_id", "w")
	method_id_file.write(method_id)

	# Write the input data in
	data_file = open(path + guid + "/data", "wb")
	data_file.write(data_in)
	data_file.close()

	# Read the data back to trigger execution
	data_file = open(path + guid + "/data", "rb")
	data_out = data_file.read()
	data_file.close()

	method_id_file.close()
	instance_file.close()

Unfortunately, as you can see this isn't nice, and very racy. To point out the 
more glaring flaws:

1) instance and method_id can be changed before we start reading and writing 
in any data.

2) Executing a method involves reading back from the 'data' file (but if we 
don't care about the output, this makes little sense). If anything changes 
before this, then either the method will fail, or we may not execute what we 
intended to.

3) For method execution, this really comes across as rather 'clunky' means to 
do so

At this point, I'm seriously looking into replacing the sysfs userspace 
interface with ioctl's instead, but I'd like some thoughts either way, as I'm 
not that sure where to go from here.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
